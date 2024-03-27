#!/usr/bin/env python3
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("benchmark.csv")
df["file_size"] = df["file_size"] / (1024 ** 3)
df.loc[:, df.columns.str.contains("memory")] = df.loc[:, df.columns.str.contains("memory")].apply(lambda x: x / (1024 ** 2))
df.sort_values("file_size", inplace=True)


df.loc[:, df.columns.str.contains("traversal")] = df.loc[:, df.columns.str.contains("traversal")].apply(lambda x: x / 1000)
df.loc[:, df.columns.str.contains("time")] = df.loc[:, df.columns.str.contains("time")].apply(lambda x: x.apply(lambda y: float(y.split(":")[0]) * 60 + float(y.split(":")[1])))

# Remove chr16
df.drop([7], inplace=True)

print(df.head(n=25))

print(f"Packed factor: {(df['odgi_traversal'] / df['packed_traversal']).mean()}")
print(f"Hash-Packed factor: {(df['packed_traversal'] / df['hash_traversal']).mean()}")
print(f"Hash-Odgi factor: {(df['odgi_traversal'] / df['hash_traversal']).mean()}")
print(f"Packed increase: {df.iloc[-1, 5] / df.iloc[0, 5]}")
print(f"Odgi increase: {df.iloc[-1, 2] / df.iloc[0, 2]}")
print(f"Hash increase: {df.iloc[-1, 8] / df.iloc[0, 8]}")
print(f"Memory factor p: {(df['packed_memory'] / df['file_size']).mean()}")
print(f"Memory factor h: {(df['hash_memory'] / df['file_size']).mean()}")
print(f"Memory factor o: {(df['odgi_memory'] / df['file_size']).mean()}")


def adjust_annotation_position(x, y, ax, label):
    ann = ax.annotate(label, (x, y),
                      xycoords='axes fraction',
                      verticalalignment='bottom',
                      horizontalalignment='center',
                      rotation=270)
    bbox = ann.get_window_extent()
    collision = True

    while collision:
        collision = False
        for annotation in ax.texts:
            if annotation == ann:
                continue
            if bbox.intersection(bbox, annotation.get_window_extent()):
                collision = True
                ann.set_position((ann.get_position()[0], ann.get_position()[1] + 0.02))
                bbox = ann.get_window_extent()
                break


def draw_graph(kind, ylabel, log=False):
    fig, ax = plt.subplots(figsize=(7, 5))
    ax.scatter(df["file_size"], df["odgi_" + kind], label="odgi", s=24)
    ax.scatter(df["file_size"], df["packed_" + kind], label="rs-handlegraph packed graph", s=24)
    ax.scatter(df["file_size"], df["hash_" + kind], label="rs-handlegraph hash graph", s=24)

    if kind == "traversal":
        ax.legend(loc='upper left')
    else:
        ax.legend()
    ax.set_xlabel("File size in GB")
    ax.set_ylabel(ylabel)

    if log:
        ax.set_yscale('log')

    x_bounds = ax.get_xlim()
    for index, row in df.iterrows():
        ax.axvline(x=row["file_size"], ymin=0, ymax=1, c="grey", linestyle="dashed", alpha=0.5)
        adjust_annotation_position(((row["file_size"]-x_bounds[0])/(x_bounds[1]-x_bounds[0])), 1.01, ax, row["file_name"])
    ax.autoscale()

    plt.savefig(f"{kind}.png", bbox_inches="tight", pad_inches=0.5)


if __name__ == "__main__":
    print(df.head())
    draw_graph("traversal", "Time for traversal in sec", log=True)
    # draw_graph("time", "Time in total in sec", log=True)
    draw_graph("memory", "Max. memory usage in Gb")
